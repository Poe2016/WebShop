package test;

import java.io.Serializable;  
public class City implements Serializable{  
 private static final long serialVersionUID = 4558876127402513L;  
 private String name;  
 private String code;  
 public String getCode() {  
  return code;  
 }  
 public void setCode(String code) {  
  this.code = code;  
 }  
 public String getName() {  
  return name;  
 }  
 public void setName(String name) {  
  this.name = name;  
 }  
}  
