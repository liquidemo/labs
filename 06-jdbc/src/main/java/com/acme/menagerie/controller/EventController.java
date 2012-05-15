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

import com.acme.menagerie.dao.EventRepository;
import com.acme.menagerie.model.Event;

/**
 * Controller handling all pet requests.
 */
@Controller
@RequestMapping("/events")
public class EventController {

    protected static Logger logger = Logger.getLogger("controller");

    @Autowired
    private EventRepository eventRepository;

    /**
     * Renders a page with all events in the repository.
     */
    @RequestMapping(method=GET)
    public String list(Model model) {
        logger.debug("Received request to show all events");
        List<Event> events = eventRepository.list();
        model.addAttribute("events", events);
        return "events";
    }

    /**
     * Adds a new event to the repository.
     */
    @RequestMapping(method=POST, value="/add")
    public String add(@ModelAttribute Event event) {
        logger.debug("Received request to add new event");
        eventRepository.add(event);
        return "redirect:/events";
    }

    /**
     * Removes an existing event from the repository.
     */
    @RequestMapping(method=POST, value="/remove")
    public String remove(@RequestParam("name") String name, Model model) {
        logger.debug("Received request to remove existing event from database");
        eventRepository.remove(name);
        model.addAttribute("name", name);
        return "redirect:/events";
    }

    /**
     * Updates an existing event in the repository.
     */
    @RequestMapping(method=POST, value="/edit")
    public String update(@RequestParam("oldname") String oldname, @ModelAttribute Event event, Model model) {
        logger.debug("Received request to update existing event in database");
        eventRepository.update(oldname, event);
        model.addAttribute("name", oldname);
        return "redirect:/events";
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
