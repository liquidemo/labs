package com.acme.menagerie.dao;

import java.util.List;

import com.acme.menagerie.model.Pet;

public interface PetRepository {

    /**
     * Returns a list of all pets in the database.
     * 
     * @return a list of pets.
     */
    public abstract List<Pet> list();

    /**
     * Returns a list of all pets in the database.
     * 
     * @return a list of pets.
     */
    public abstract Pet get(String name);

    /**
     * Adds a new pet to the database.
     * 
     * @param pet the pet to add.
     */
    public abstract void add(Pet pet);

    /**
     * Deletes an existing pet from the database.
     * 
     * @param name of the pet to delete.
     */
    public abstract void remove(String name);

    /**
     * Updates an existing pet in the database.
     * 
     * @param oldName the old name of the pet.
     * @param pet the new pet.
     */
    public abstract void update(String oldName, Pet pet);

}