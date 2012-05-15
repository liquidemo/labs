package com.acme.menagerie.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.acme.menagerie.model.Pet;

/**
 * JDBC implementation of the PetRepository interface.
 */
@Repository
@Transactional
public class JdbcPetRepository implements PetRepository {

    protected static Logger logger = Logger.getLogger("dao");

    private NamedParameterJdbcTemplate jdbcTemplate;

    @Resource(name = "dataSource")
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    /* (non-Javadoc)
     * @see com.acme.menagerie.dao.IPetRepository#list()
     */
    public List<Pet> list() {
        logger.debug("Fetching all pets in database");

        String sql = "SELECT name, owner, species, sex, birth, death FROM pet ORDER BY name ASC";

        RowMapper<Pet> mapper = new RowMapper<Pet>() {
            public Pet mapRow(ResultSet rs, int rowNum) throws SQLException {
                Pet pet = new Pet();
                pet.setName(rs.getString("name"));
                pet.setOwner(rs.getString("owner"));
                pet.setSpecies(rs.getString("species"));
                pet.setSex(rs.getString("sex"));
                pet.setBirth(rs.getDate("birth"));
                pet.setDeath(rs.getDate("death"));
                return pet;
            }
        };

        return jdbcTemplate.query(sql, (SqlParameterSource) null, mapper);
    }
    
    /* (non-Javadoc)
     * @see com.acme.menagerie.dao.IPetRepository#get(java.lang.String)
     */
    public Pet get(String name) {
        logger.debug("Fetching all pets in database");

        String sql = "SELECT name, owner, species, sex, birth, death FROM pet WHERE name = :name";

        RowMapper<Pet> mapper = new RowMapper<Pet>() {
            public Pet mapRow(ResultSet rs, int rowNum) throws SQLException {
                Pet pet = new Pet();
                pet.setName(rs.getString("name"));
                pet.setOwner(rs.getString("owner"));
                pet.setSpecies(rs.getString("species"));
                pet.setSex(rs.getString("sex"));
                pet.setBirth(rs.getDate("birth"));
                pet.setDeath(rs.getDate("death"));
                return pet;
            }
        };

        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("name", name);
        
        return jdbcTemplate.queryForObject(sql, parameters, mapper);
    }    

    /* (non-Javadoc)
     * @see com.acme.menagerie.dao.IPetRepository#add(com.acme.menagerie.model.Pet)
     */
    public void add(Pet pet) {
        logger.debug("Adding new pet to database");

        String sql = " INSERT INTO pet (name, owner, species, sex, birth, death) " +
                     " VALUES (:name, :owner, :species, :sex, :birth, :death)    " ;

        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("name", pet.getName());
        parameters.put("owner", pet.getOwner());
        parameters.put("species", pet.getSpecies());
        parameters.put("sex", pet.getSex());
        parameters.put("birth", pet.getBirth());
        parameters.put("death", pet.getDeath());

        jdbcTemplate.update(sql, parameters);
    }

    /* (non-Javadoc)
     * @see com.acme.menagerie.dao.IPetRepository#remove(java.lang.String)
     */
    public void remove(String name) {
        logger.debug("Removing existing pet from database");

        String sql = "DELETE FROM pet WHERE name = :name";
        
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("name", name);
        
        jdbcTemplate.update(sql, parameters);
    }

    /* (non-Javadoc)
     * @see com.acme.menagerie.dao.IPetRepository#update(java.lang.String, com.acme.menagerie.model.Pet)
     */
    public void update(String oldName, Pet pet) {
        logger.debug("Updating existing pet in database");

        String sql = (
                " UPDATE pet                 " +
                " SET name    = :name,       " +
                "     owner   = :owner,      " +
                "     species = :species,    " +
                "     sex     = :sex,        " +
                "     birth   = :birth,      " +
                "     death   = :death       " +
                " WHERE name = :oldname      " );

        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("oldname", oldName);
        parameters.put("name", pet.getName());
        parameters.put("owner", pet.getOwner());
        parameters.put("species", pet.getSpecies());
        parameters.put("sex", pet.getSex());
        parameters.put("birth", pet.getBirth());
        parameters.put("death", pet.getDeath());

        jdbcTemplate.update(sql, parameters);
    }
}
