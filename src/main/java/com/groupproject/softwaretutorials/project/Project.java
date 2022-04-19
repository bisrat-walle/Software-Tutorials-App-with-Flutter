package com.groupproject.softwaretutorials.project;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import lombok.Data;
import java.io.Serializable;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

@Entity
@Data
public class Project implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long projectId;

    
    @Column(length = 50)
    private String title;

    
    @Column(length = 1000)
    private String problemStatement;
}
