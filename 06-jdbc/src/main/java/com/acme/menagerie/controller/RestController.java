package com.acme.menagerie.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.acme.menagerie.dao.PetRepository;
import com.acme.menagerie.model.Pet;

@Controller
@RequestMapping("/api/pets")
public class RestController {

    protected static Logger logger = Logger.getLogger("api");

    @Autowired
    private PetRepository petRepository;

    @RequestMapping(method=GET)
    @ResponseBody
    public List<Pet> getPets() {
        List<Pet> pets = petRepository.list();
        return pets;
    }

}
