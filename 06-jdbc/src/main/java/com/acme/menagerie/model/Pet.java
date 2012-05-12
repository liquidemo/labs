package com.acme.menagerie.model;

import java.util.Date;

/**
 * A simple POJO representing a Pet
 */
public class Pet {

    private String name;
    private String owner;
    private String species;
    private String sex;
    private Date birth;
    private Date death;
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getOwner() {
        return owner;
    }
    
    public void setOwner(String owner) {
        this.owner = owner;
    }
    
    public String getSpecies() {
        return species;
    }
    
    public void setSpecies(String species) {
        this.species = species;
    }
    
    public String getSex() {
        return sex;
    }
    
    public void setSex(String sex) {
        this.sex = sex;
    }
    
    public Date getBirth() {
        return birth;
    }
    
    public void setBirth(Date birth) {
        this.birth = birth;
    }
    
    public Date getDeath() {
        return death;
    }
    
    public void setDeath(Date death) {
        this.death = death;
    }
    
}
