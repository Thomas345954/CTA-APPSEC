package com.cta.boir.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Comments extends AuditModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;
    private String bdname;
    private String bdemail;
    private String bdmessage;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return bdname;
	}
	public void setName(String bdname) {
		this.bdname = bdname;
	}
	public String getEmail_id() {
		return bdemail;
	}
	public void setEmail_id(String bdemail) {
		this.bdemail = bdemail;
	}
	public String getComments() {
		return bdmessage;
	}
	public void setComments(String bdmessage) {
		this.bdmessage = bdmessage;
	}
	
    
        	
    
    
}
