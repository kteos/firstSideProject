package com.techelevator.addressbook.model.dao.jdbc;

import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.addressbook.model.Person;
import com.techelevator.addressbook.model.dao.PersonDao;

@Component

public class JdbcPersonDao implements PersonDao {

private JdbcTemplate jdbcTemplate;

public JdbcPersonDao(JdbcTemplate jdbcTemplate) {
	this.jdbcTemplate = jdbcTemplate;
}

	@Override
	public List<Person> getAllPeople() {
		List<Person> people = new ArrayList<Person>();
		String sqlSelect = "SELECT person_id, first_name, last_name, date_added FROM person";
		SqlRowSet rowset = jdbcTemplate.queryForRowSet(sqlSelect);
		while(rowset.next()) {
			Person person = makePersonFromRow(rowset);
			people.add(person);
		}
		
		return people;
	}
	
	private Person makePersonFromRow(SqlRowSet rowSet) {
		Person person = new Person();
		person.setPersonId(rowSet.getInt("person_id"));
		person.setFirstName(rowSet.getString("first_name"));
		person.setLastName(rowSet.getString("last_name"));
		person.setDateAdded(rowSet.getDate("date_added").toLocalDate());
		
		return person;
	}

}
