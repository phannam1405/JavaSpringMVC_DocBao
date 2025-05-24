package net.codejava.repository;

import org.springframework.data.repository.CrudRepository;


import net.codejava.model.Comment;

public interface CommentRepository extends CrudRepository<Comment, Integer>{

}
