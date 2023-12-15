package org.zerock.common.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
@ComponentScan(basePackages={"org.zerock.board.service", "org.zerock.reply.service"})
@MapperScan(basePackages= {"org.zerock.board.mapper", "org.zerock.reply.mapper"})
public class RootConfig {

    ApplicationContext applicationContext;

    @Bean
    public DataSource dataSource() {
        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
        hikariConfig.setJdbcUrl("jdbc:log4jdbc:mysql://localhost:3306/ex00?serverTimezone=Asia/Seoul");
//        hikariConfig.setDriverClassName("com.mysql.cj.jdbc.Driver");
//        hikariConfig.setJdbcUrl("jdbc:mysql://localhost/ex00");
        hikariConfig.setUsername("root");
        hikariConfig.setPassword("1234");


        HikariDataSource dataSource = new HikariDataSource(hikariConfig);

        return dataSource;
    }

    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
        sqlSessionFactory.setDataSource(dataSource());
//        sqlSessionFactory.setMapperLocations(applicationContext.getResources("classpath:/org.zerock.board.mapper/*Mapper.xml"));
        return (SqlSessionFactory) sqlSessionFactory.getObject();
    }
}
