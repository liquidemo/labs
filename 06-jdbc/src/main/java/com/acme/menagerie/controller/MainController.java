package com.acme.menagerie.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import schemacrawler.schema.Schema;

import com.acme.menagerie.util.SchemaUtil;

@Controller
@RequestMapping
public class MainController {

    protected static Logger logger = Logger.getLogger("controller");
    
    @Autowired
    private DataSource dataSource;
    
    @RequestMapping(method=GET)
    public String getIndex(Model model) {
        return "home";
    }

    @RequestMapping(method=GET, value="/introduction")
    public String getHome(Model model) {
        return "introduction";
    }

    @RequestMapping(method=GET, value="/excercises")
    public String excercises(Model model) {
        return "excercises";
    }
    
    
    @RequestMapping(method=GET, value="/schema")
    public String getSchema(Model model) throws Exception {
        Schema[] schemas = SchemaUtil.getInstance().getSchemas(dataSource);
        model.addAttribute("schema", schemas[1]);
        model.addAttribute("schemajson", SchemaUtil.toJson(dataSource));
        return "schema";
    }

    @RequestMapping(method=GET, value="/changelog")
    public String getChangeLog(Model model) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        List<Map<String,Object>> changesets = jdbcTemplate.queryForList("SELECT * FROM databasechangelog");
        model.addAttribute("changesets", changesets);
        return "changelog";
    }
    
}
