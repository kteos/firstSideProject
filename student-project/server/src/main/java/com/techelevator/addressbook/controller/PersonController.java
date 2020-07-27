package com.techelevator.addressbook.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.addressbook.model.Person;
import com.techelevator.addressbook.model.dao.PersonDao;

@RestController
public class PersonController {
	
	@Autowired
	private PersonDao personDao;
	
	
	
	
	@RequestMapping(path = "/peoples" , method=RequestMethod.GET)
	public List<Person> list(){
		return personDao.getAllPeople();
	}

}
