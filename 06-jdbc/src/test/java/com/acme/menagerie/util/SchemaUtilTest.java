package com.acme.menagerie.util;

import static org.junit.Assert.assertEquals;

import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

import com.google.gson.JsonElement;

@ContextConfiguration(classes=SchemaUtilTestConfig.class)
public class SchemaUtilTest extends AbstractTransactionalJUnit4SpringContextTests {
        
    @Autowired 
    DataSource dataSource; 

    @Test
    public void testSchemaToJson() throws Exception {
        JsonElement json = SchemaUtil.toJsonTree(dataSource);
        assertEquals(2, json.getAsJsonArray().size());
     }

}
