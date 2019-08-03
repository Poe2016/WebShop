package test;

import java.io.Serializable;  
import java.util.Date;  
import java.util.List;  
public class TestObject implements Serializable {  
   
 private static final long serialVersionUID = 4558876142427402513L;  
 /** 
  * @param args 
  */  
 private String name;  
 private String password;  
 private Date date;  
 private List<City> cityList;  
   
 public List<City> getCityList() {  
  return cityList;  
 }  
 public void setCityList(List<City> cityList) {  
  this.cityList = cityList;  
 }  
 public Date getDate() {  
  return date;  
 }  
 public void setDate(Date date) {  
  this.date = date;  
 }  
 public String getName() {  
  return name;  
 }  
 public void setName(String name) {  
  this.name = name;  
 }  
 public String getPassword() {  
  return password;  
 }  
 public void setPassword(String password) {  
  this.password = password;  
 }  
}  
