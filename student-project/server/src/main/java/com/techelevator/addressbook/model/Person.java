package com.techelevator.addressbook.model;

import java.time.LocalDate;

public class Person {
	
private int personId;
private String firstName;
private String lastName;
private LocalDate dateAdded;




public int getPersonId() {
	return personId;
}
public void setPersonId(int personId) {
	this.personId = personId;
}
public String getFirstName() {
	return firstName;
}
public void setFirstName(String firstName) {
	this.firstName = firstName;
}
public String getLastName() {
	return lastName;
}
public void setLastName(String lastName) {
	this.lastName = lastName;
}
public LocalDate getDateAdded() {
	return dateAdded;
}
public void setDateAdded(LocalDate dateAdded) {
	this.dateAdded = dateAdded;
}



}
