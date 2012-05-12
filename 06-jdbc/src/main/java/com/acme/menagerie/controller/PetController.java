package com.acme.menagerie.controller;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.PUT;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.acme.menagerie.dao.PetRepository;
import com.acme.menagerie.model.Pet;

/**
 * Controller handling all pet requests.
 */
@Controller
@RequestMapping("/pets")
public class PetController {

    protected static Logger logger = Logger.getLogger("controller");

    @Autowired
    private PetRepository petRepository;

    /**
     * Renders a page with all pets in the repository.
     */
    @RequestMapping(method=GET)
    public String getPets(Model model) {
        logger.debug("Received request to show all pets");
        List<Pet> pets = petRepository.list();
        model.addAttribute("pets", pets);
        return "petspage";
    }

    /**
     * Adds a new pet to the repository.
     */
    @RequestMapping(method=POST)
    public String add(@ModelAttribute Pet pet) {
        logger.debug("Received request to add new pet");
        petRepository.add(pet);
        return "addedpage";
    }

    /**
     * Removes an existing pet from the repository.
     */
    @RequestMapping(method=DELETE)
    public String remove(@RequestParam(value="name", required=true) String name, Model model) {
        logger.debug("Received request to remove existing pet from database");
        petRepository.remove(name);
        model.addAttribute("name", name);
        return "deletedpage";
    }

    /**
     * Updates an existing pet in the repository.
     */
    @RequestMapping(method=PUT, value="/{name}", consumes="application/x-www-form-urlencoded")
    public String update(String name, @RequestBody Pet pet, Model model) {
        logger.debug("Received request to update existing pet in database");
        petRepository.update(name, pet);
        model.addAttribute("name", name);
        return "editedpage";
    }
}
