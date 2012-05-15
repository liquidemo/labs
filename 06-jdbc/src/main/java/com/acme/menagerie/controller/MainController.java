package com.acme.menagerie.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping
public class MainController {

    protected static Logger logger = Logger.getLogger("controller");
        
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
    
      
}
