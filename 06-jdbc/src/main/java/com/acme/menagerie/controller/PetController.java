package com.acme.menagerie.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.beans.PropertyEditorSupport;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
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
    public String list(Model model) {
        logger.debug("Received request to show all pets");
        List<Pet> pets = petRepository.list();
        model.addAttribute("pets", pets);
        return "pets";
    }

    /**
     * Adds a new pet to the repository.
     */
    @RequestMapping(method=POST, value="/add")
    public String add(@ModelAttribute Pet pet) {
        logger.debug("Received request to add new pet");
        petRepository.add(pet);
        return "redirect:/pets";
    }

    /**
     * Removes an existing pet from the repository.
     */
    @RequestMapping(method=POST, value="/remove")
    public String remove(@RequestParam("name") String name, Model model) {
        logger.debug("Received request to remove existing pet from database");
        petRepository.remove(name);
        model.addAttribute("name", name);
        return "redirect:/pets";
    }

    /**
     * Updates an existing pet in the repository.
     */
    @RequestMapping(method=POST, value="/edit")
    public String update(@RequestParam("oldname") String oldname, @ModelAttribute Pet pet, Model model) {
        logger.debug("Received request to update existing pet in database");
        petRepository.update(oldname, pet);
        model.addAttribute("name", oldname);
        return "redirect:/pets";
    }
    
    @InitBinder
    public void binder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
            public void setAsText(String value) {
                try {
                    setValue(new SimpleDateFormat("yyyy-MM-dd").parse(value));
                }
                catch (Exception e) {
                    setValue(null);
                }
            }
            public String getAsText() {
                return new SimpleDateFormat("yyy-MM-dd").format((Date) getValue());
            }        
        });
    }    
}
