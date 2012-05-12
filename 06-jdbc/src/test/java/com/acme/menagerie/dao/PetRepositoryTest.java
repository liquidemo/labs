package com.acme.menagerie.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.transaction.AfterTransaction;
import org.springframework.test.context.transaction.BeforeTransaction;

import com.acme.menagerie.model.Pet;

@ContextConfiguration(classes=PetRepositoryTestConfig.class)
public class PetRepositoryTest extends AbstractTransactionalJUnit4SpringContextTests {

    @Autowired
    PetRepository petRepository;
        
    @BeforeTransaction
    public void beforeTransaction() throws Exception {
        assertEquals("Pet table should be empty", 0, countRowsInTable("pet"));
        assertEquals("Event table should be empty", 0, countRowsInTable("event"));
    }
    
    @AfterTransaction
    public void afterTransaction() throws Exception {
        assertEquals("Pet table should be empty", 0, countRowsInTable("pet"));
        assertEquals("Event table should be empty", 0, countRowsInTable("event"));
    }
    
    @Before
    public void setUp() throws Exception {
        assertNotNull(petRepository);
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void testList() {
        List<Pet> pets = petRepository.list();
        assertEquals("Repository should be empty", 0, pets.size());
    }

    @Test
    public void testGet() {
        Pet expectedPet = new Pet();
        expectedPet.setName("foo");
        petRepository.add(expectedPet);
        assertEquals("Pet table should contain a single row ", 1, countRowsInTable("pet"));
        Pet actualPet = petRepository.get("foo");
        assertEquals("Names should match", expectedPet.getName(), actualPet.getName());
    }

    @Test
    public void testAdd() {
        Pet pet = new Pet();
        pet.setName("foo");
        petRepository.add(pet);
        assertEquals("Pet table should contain a single row ", 1, countRowsInTable("pet"));
    }

    @Test
    public void testRemove() {
        Pet expectedPet = new Pet();
        expectedPet.setName("foo");
        petRepository.add(expectedPet);
        assertEquals("Pet table should contain a single row ", 1, countRowsInTable("pet"));
        petRepository.remove("foo");
        assertEquals("Pet table should be empty ", 0, countRowsInTable("pet"));
    }

    @Test
    public void testUpdate() {
        Pet expectedPet = new Pet();
        expectedPet.setName("foo");
        expectedPet.setOwner("bill");
        expectedPet.setSpecies("cat");
        petRepository.add(expectedPet);
        expectedPet.setOwner("lisa");
        assertEquals("Pet table should contain a single row ", 1, countRowsInTable("pet"));
        petRepository.update("foo", expectedPet);
        assertEquals("Pet table should contain a single row ", 1, countRowsInTable("pet"));
        Pet actualPet = petRepository.get("foo");
        assertEquals("Owner was not updated correctly", "lisa", actualPet.getOwner());
    }

}
