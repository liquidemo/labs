package com.acme.menagerie.dao;

import java.util.List;

import com.acme.menagerie.model.Event;

public interface EventRepository {

    /**
     * Returns a list of all events in the database.
     * 
     * @return a list of events.
     */
    public abstract List<Event> list();

    /**
     * Returns a list of all events in the database.
     * 
     * @return a list of events.
     */
    public abstract Event get(String name);

    /**
     * Adds a new event to the database.
     * 
     * @param event the event to add.
     */
    public abstract void add(Event event);

    /**
     * Deletes an existing event from the database.
     * 
     * @param name of the event to delete.
     */
    public abstract void remove(String name);

    /**
     * Updates an existing event in the database.
     * 
     * @param oldName the old name of the event.
     * @param event the updated event.
     */
    public abstract void update(String oldName, Event event);

}