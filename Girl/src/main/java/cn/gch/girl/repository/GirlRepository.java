package cn.gch.girl.repository;

import cn.gch.girl.entity.Girl;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GirlRepository extends JpaRepository<Girl,Integer> {
    //通过年龄来查询
    public List<Girl> findByAge(Integer age) ;
}
