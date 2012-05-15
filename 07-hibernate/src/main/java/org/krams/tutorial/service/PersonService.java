package org.krams.tutorial.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.krams.tutorial.entity.Person;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service for processing Persons
 * 
 */
@Service("personService")
@Transactional
public class PersonService {

	protected static Logger logger = Logger.getLogger("service");
	
	@Resource(name="sessionFactory")
	private SessionFactory sessionFactory;
	
	/**
	 * Retrieves all persons
	 * 
	 * @return a list of persons
	 */
	public List<Person> getAll() {
		logger.debug("Retrieving all persons");
		
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		
		// Create a Hibernate query (HQL)
		Query query = session.createQuery("FROM  Person");
		
		// Retrieve all
		return  query.list();
	}
	
	/**
	 * Adds a new person
	 * 
	 * @param firstName the first name of the person
	 * @param lastName the last name of the person
	 * @param money the money of the person
	 */
	public void add(String firstName, String lastName, Double money) {
		logger.debug("Adding new person");
		
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		
		// Create a new person
		Person person = new Person();
		person.setFirstName(firstName);
		person.setLastName(lastName);
		person.setMoney(money);
		
		// Save
		session.save(person);
	}
	
	/**
	 * Deletes an existing person
	 * @param id the id of the existing person
	 */
	public void delete(Integer id) {
		logger.debug("Deleting existing person");
		
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		
		// Retrieve existing person first
		Person person = (Person) session.get(Person.class, id);
		
		// Delete 
		session.delete(person);
	}
	
	/**
	 * Edits an existing person
	 * @param id the id of the existing person
	 * @param firstName the first name of the existing person
	 * @param lastName the last name of the existing person
	 * @param money the money of the existing person
	 */
	public void edit(Integer id, String firstName, String lastName, Double money) {
		logger.debug("Editing existing person");
		
		// Retrieve session from Hibernate
		Session session = sessionFactory.getCurrentSession();
		
		// Retrieve existing person via id
		Person person = (Person) session.get(Person.class, id);
		
		// Assign updated values to this person
		person.setFirstName(firstName);
		person.setLastName(lastName);
		person.setMoney(money);

		// Save updates
		session.save(person);
	}
}
