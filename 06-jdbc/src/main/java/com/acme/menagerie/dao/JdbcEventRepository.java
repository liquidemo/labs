package com.acme.menagerie.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.acme.menagerie.model.Event;

/**
 * JDBC implementation of the EventRepository interface.
 */
@Repository
@Transactional
public class JdbcEventRepository implements EventRepository {

    protected static Logger logger = Logger.getLogger("dao");

    private NamedParameterJdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public List<Event> list() {
        logger.debug("Fetching all events in database");

        String sql = "SELECT name, date, type, remark FROM event ORDER BY date DESC";

        RowMapper<Event> mapper = new RowMapper<Event>() {
            public Event mapRow(ResultSet rs, int rowNum) throws SQLException {
                Event event = new Event();
                event.setName(rs.getString("name"));
                event.setDate(rs.getDate("date"));
                event.setType(rs.getString("type"));
                event.setRemark(rs.getString("remark"));
                return event;
            }
        };

        return jdbcTemplate.query(sql, (SqlParameterSource) null, mapper);
    }
    
    public Event get(String name) {
        logger.debug("Fetching all events in database");

        String sql = "SELECT name, type, date, remark FROM event WHERE name = :name";

        RowMapper<Event> mapper = new RowMapper<Event>() {
            public Event mapRow(ResultSet rs, int rowNum) throws SQLException {
                Event event = new Event();
                event.setName(rs.getString("name"));
                event.setType(rs.getString("type"));
                event.setDate(rs.getDate("date"));
                event.setRemark(rs.getString("remark"));
                return event;
            }
        };

        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("name", name);
        
        return jdbcTemplate.queryForObject(sql, parameters, mapper);
    }    

    public void add(Event event) {
        logger.debug("Adding new event to database");

        String sql = " INSERT INTO event (name, type, date, remark) " +
                     " VALUES (:name, :type, :date, :remark)        " ;

        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("name", event.getName());
        parameters.put("type", event.getType());
        parameters.put("date", event.getDate());
        parameters.put("remark", event.getRemark());

        jdbcTemplate.update(sql, parameters);
    }

    public void remove(String name) {
        logger.debug("Removing existing event from database");

        String sql = "DELETE FROM event WHERE name = :name";
        
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("name", name);
        
        jdbcTemplate.update(sql, parameters);
    }

    public void update(String oldName, Event event) {
        logger.debug("Updating existing event in database");

        String sql = (
                " UPDATE event               " +
                " SET name    = :name,       " +
                "     type    = :type,       " +
                "     date    = :date,       " +
                "     remark  = :remark      " +
                " WHERE name = :oldname      " );

        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("oldname", oldName);
        parameters.put("name", event.getName());
        parameters.put("type", event.getType());
        parameters.put("date", event.getDate());
        parameters.put("remark", event.getRemark());

        jdbcTemplate.update(sql, parameters);
    }
}
