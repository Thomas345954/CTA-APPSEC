package com.cta.boir.service;

import com.cta.boir.model.Comments;
import com.cta.boir.repository.CommentsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CommentsService {
    @Autowired
    private CommentsRepository commentsRepository;

    public List<Comments> getAllComments() {
        return commentsRepository.findAll();
    }

    public Optional<Comments> getCommentsById(Long id) {
        return commentsRepository.findById(id);
    }

    public Comments saveComments(Comments comments) {
        return commentsRepository.save(comments);
    }

    public void deleteComments(Long id) {
    	commentsRepository.deleteById(id);
    }
    
}
