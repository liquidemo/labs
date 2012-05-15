package com.acme.menagerie.util;

import java.lang.reflect.Type;
import java.sql.Connection;

import javax.sql.DataSource;

import schemacrawler.schema.Column;
import schemacrawler.schema.ForeignKey;
import schemacrawler.schema.ForeignKeyColumnMap;
import schemacrawler.schema.Index;
import schemacrawler.schema.IndexColumn;
import schemacrawler.schema.PrimaryKey;
import schemacrawler.schema.Schema;
import schemacrawler.schema.Table;
import schemacrawler.schemacrawler.SchemaCrawlerOptions;
import schemacrawler.schemacrawler.SchemaInfoLevel;
import schemacrawler.utility.SchemaCrawlerUtility;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

public class SchemaUtil {

    private static SchemaUtil instance;
    
    protected SchemaUtil() {
    }
    
    public static String toJson(DataSource dataSource) throws Exception {
        Schema[] schemas = getInstance().getSchemas(dataSource);
        String json = getInstance().buildGson().toJson(schemas);
        return json;
    }

    public static JsonElement toJsonTree(DataSource dataSource) throws Exception {
        Schema[] schemas = getInstance().getSchemas(dataSource);
        JsonElement json = getInstance().buildGson().toJsonTree(schemas);
        return json;
    }
    
    public synchronized static SchemaUtil getInstance() {
        if (instance == null) {
            instance = new SchemaUtil();
        }
        return instance;
    }
    
    public Schema[] getSchemas(DataSource dataSource) throws Exception {
        Connection connection = null;    
        try {
            connection = dataSource.getConnection();
            SchemaCrawlerOptions options = new SchemaCrawlerOptions();
            options.setSchemaInfoLevel(SchemaInfoLevel.standard());
            schemacrawler.schema.Database database = SchemaCrawlerUtility.getDatabase(connection, options);
            Schema[] schemas = database.getSchemas();
            return schemas;
        }
        finally {
            if (connection != null) {
                connection.close();
            }
        }
    }
    
    protected Gson buildGson() {
        GsonBuilder gsonBuilder = new GsonBuilder();
        gsonBuilder.registerTypeAdapter(Schema.class, new SchemaSerializer());
        gsonBuilder.registerTypeAdapter(Table.class, new TableSerializer());
        gsonBuilder.registerTypeAdapter(Column.class, new ColumnSerializer());
        gsonBuilder.registerTypeAdapter(IndexColumn.class, new ColumnSerializer());
        gsonBuilder.registerTypeAdapter(PrimaryKey.class, new PrimaryKeySerializer());
        gsonBuilder.registerTypeAdapter(ForeignKey.class, new ForeignKeySerializer());
        gsonBuilder.registerTypeAdapter(Index.class, new IndexSerializer());
        gsonBuilder.setPrettyPrinting();
        Gson gson = gsonBuilder.create();
        return gson;
    }
    
    private class SchemaSerializer implements JsonSerializer<Schema> {
        public JsonElement serialize(Schema src, Type typeOfSrc, JsonSerializationContext context) {
            JsonObject jsonSchema = new JsonObject();
            jsonSchema.addProperty("name", src.getName());
            
            JsonElement jsonTablesAndViews = context.serialize(src.getTables());
            JsonArray jsonTables = new JsonArray();
            JsonArray jsonViews = new JsonArray();
            
            for (JsonElement element : jsonTablesAndViews.getAsJsonArray()) {
                JsonObject jsonTable = element.getAsJsonObject();
                String type = jsonTable.getAsJsonPrimitive("type").getAsString();
                if (type.equals("view")) {
                    jsonViews.add(element);
                }
                else {
                    jsonTables.add(element);
                }
            }
            
            jsonSchema.add("tables", jsonTables);
            jsonSchema.add("views", jsonViews);
            return jsonSchema;
        }
    }

    private class TableSerializer implements JsonSerializer<Table> {
        public JsonElement serialize(Table src, Type typeOfSrc, JsonSerializationContext context) {
            JsonObject jsonTable = new JsonObject();
            jsonTable.addProperty("name", src.getName());
            String tableType = src.getType().name();
            jsonTable.addProperty("type", tableType);
            jsonTable.add("columns", context.serialize(src.getColumns()));
            if (tableType.equals("table")) {
                jsonTable.add("primaryKey", context.serialize(src.getPrimaryKey(), PrimaryKey.class));
                jsonTable.add("foreignKeys", context.serialize(src.getImportedForeignKeys()));
            }
            jsonTable.add("indices", context.serialize(src.getIndices()));
            return jsonTable;
        }
    }
    
    private class ColumnSerializer implements JsonSerializer<Column> {
        public JsonElement serialize(Column src, Type typeOfSrc, JsonSerializationContext context) {
            JsonObject jsonColumn = new JsonObject();
            jsonColumn.addProperty("name", src.getName());
            jsonColumn.addProperty("type", src.getType().getName());
            jsonColumn.addProperty("size", src.getSize());
            jsonColumn.addProperty("isNullable", src.isNullable());
            jsonColumn.addProperty("isUnique", src.isPartOfUniqueIndex());
            jsonColumn.addProperty("isForeignKey", src.isPartOfForeignKey());
            jsonColumn.addProperty("isPrimaryKey", src.isPartOfPrimaryKey());
            jsonColumn.addProperty("isAutoIncrement", src.getType().isAutoIncrementable());
            return jsonColumn;
        }
    }

    private class IndexSerializer implements JsonSerializer<Index> {
        public JsonElement serialize(Index src, Type typeOfSrc, JsonSerializationContext context) {
            JsonObject jsonIndex = new JsonObject();
            jsonIndex.addProperty("name", src.getName());
            jsonIndex.addProperty("isUnique", src.isUnique());
            JsonArray jsonColumns = new JsonArray();
            for (Column column : src.getColumns()) {
                jsonColumns.add(new JsonPrimitive(column.getName()));
            }
            jsonIndex.add("columns", jsonColumns);
            return jsonIndex;
        }
    }

    private class PrimaryKeySerializer implements JsonSerializer<PrimaryKey> {
        public JsonElement serialize(PrimaryKey src, Type typeOfSrc, JsonSerializationContext context) {
            JsonObject jsonPrimaryKey = new JsonObject();
            jsonPrimaryKey.addProperty("name", src.getName());
            JsonArray jsonColumns = new JsonArray();
            for (Column column : src.getColumns()) {
                jsonColumns.add(new JsonPrimitive(column.getName()));
            }
            jsonPrimaryKey.add("columns", jsonColumns);
            return jsonPrimaryKey;
        }
    }

    private class ForeignKeySerializer implements JsonSerializer<ForeignKey> {
        public JsonElement serialize(ForeignKey src, Type typeOfSrc, JsonSerializationContext context) {
            JsonObject jsonForeignKey = new JsonObject();
            jsonForeignKey.addProperty("name", src.getName());
            JsonArray jsonColumns = new JsonArray();
            ForeignKeyColumnMap[] mappings = src.getColumnPairs();
            for (ForeignKeyColumnMap map : mappings) {
                String referencedColumnName = map.getPrimaryKeyColumn().getName();
                String referencedTableName = map.getPrimaryKeyColumn().getParent().getName();
                String columnName = map.getForeignKeyColumn().getName();
                JsonObject jsonObject = new JsonObject();
                jsonObject.addProperty("column", columnName);
                jsonObject.addProperty("referencedColumn", referencedColumnName);
                jsonObject.addProperty("referencedTable", referencedTableName);
                jsonColumns.add(jsonObject);
            }
            jsonForeignKey.add("columns", jsonColumns);
            return jsonForeignKey;
        }
    }
}
