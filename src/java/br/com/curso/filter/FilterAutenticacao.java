/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.curso.filter;

import br.com.curso.utils.SingleConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

/**
 *
 * @author aluno
 */
@WebFilter(urlPatterns=("/*"))
public class FilterAutenticacao implements Filter {

    private static Connection conexao;
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        conexao = SingleConnection.getConnection();
    }

    @Override // interface // 
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
        throws IOException, ServletException {
        try{
            chain.doFilter(request,response);
        }catch(Exception e){
            System.out.println("Erro: "+e.getMessage());
            e.printStackTrace();
        }
        }
    @Override
    public void destroy() {
        try{
            conexao.close();
        }catch(SQLException ex){
            System.out.println("Erro: "+ex.getMessage());
            ex.printStackTrace();
        }
        
    }
    
}
