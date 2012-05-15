package com.acme.menagerie.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.io.StringWriter;
import java.io.Writer;
import java.util.List;

import javax.sql.DataSource;

import liquibase.Liquibase;
import liquibase.database.Database;
import liquibase.database.DatabaseFactory;
import liquibase.database.jvm.JdbcConnection;
import liquibase.resource.ClassLoaderResourceAccessor;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acme.menagerie.dao.PetRepository;
import com.acme.menagerie.model.Pet;
import com.acme.menagerie.util.SchemaUtil;


@Controller
@RequestMapping("/api")
public class RestController {

    protected static Logger logger = Logger.getLogger("api");

    @Autowired
    private PetRepository petRepository;
    
    @Autowired
    private DataSource dataSource;

    @RequestMapping(method=GET, value="/pets")
    @ResponseBody
    public List<Pet> getPets() {
        List<Pet> pets = petRepository.list();
        return pets;
    }

    @RequestMapping(method=GET, value="/liquibase/status/{contexts}", produces="text/plain")
    @ResponseBody
    public String liquibaseStatus(@PathVariable("contexts") String contexts) throws Exception {
        Database database = DatabaseFactory.getInstance().findCorrectDatabaseImplementation(new JdbcConnection(dataSource.getConnection()));        
        Liquibase liquibase = new Liquibase("changelog.xml", new ClassLoaderResourceAccessor(), database);
        Writer writer = new StringWriter();
        liquibase.reportStatus(true, contexts, writer);
        return writer.toString();
    }

    @RequestMapping(method=GET, value="/db/schema", produces="application/json")
    @ResponseBody
    public String schema() throws Exception {
        return SchemaUtil.toJson(dataSource); 
    }

}


