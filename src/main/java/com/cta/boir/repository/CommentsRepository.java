package com.cta.boir.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.cta.boir.model.Comments;


public interface CommentsRepository extends JpaRepository<Comments, Long> {
}
