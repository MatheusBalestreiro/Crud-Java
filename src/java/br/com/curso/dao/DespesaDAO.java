/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.curso.dao;

import br.com.curso.model.Despesa;
import static br.com.curso.utils.Conversao.data2String;
import static br.com.curso.utils.Conversao.valorDinheiro;
import br.com.curso.utils.SingleConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author aluno
 */
public class DespesaDAO implements GenericDAO{
    
    private Connection conexao;
    
    public DespesaDAO() throws Exception{
        conexao = SingleConnection.getConnection();
    }

    @Override
    public Boolean cadastrar(Object objeto) {
        Despesa  oDespesa = (Despesa) objeto;
        Boolean retorno = false;
        if (oDespesa.getIdDespesa()== 0){
            retorno = this.inserir(oDespesa);
        }else{
            retorno = this.alterar(oDespesa);
        }
        return retorno;
    }

    @Override
    public Boolean inserir(Object objeto) {
        Despesa oDespesa = (Despesa) objeto;
        PreparedStatement stmt = null;
        String sql  = "insert into despesa (descricao, valordespesa, valorpago,"
                +"datadocumento, imagemdocumento) values (?,?,?,?,?)";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oDespesa.getDescricao());
            stmt.setDouble(2, oDespesa.getValorDespesa());
            stmt.setDouble(3, oDespesa.getValorpago());
            stmt.setDate(4, new java.sql.Date(oDespesa.getDataDocumento().getTime()));
            stmt.setString(5, oDespesa.getImagemDocumento());
            stmt.execute();
            conexao.commit();
            return true;
        } catch(Exception ex){
            try{
                System.out.print("Problema ao cadastrar a Despesa! Erro: "+ex.getMessage());
                ex.printStackTrace();
                conexao.rollback();
            } catch (SQLException e){
                System.out.println("Problemas ao executar rollback"+e.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean alterar(Object objeto) {
        Despesa oDespesa = (Despesa) objeto;
        PreparedStatement stmt = null;
        String sql  = "update despesa set descricao=?, valordespesa=?, valorpago=?,"
                +"datadocumento=?, imagemdocumento=? where iddespesa=?";
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, oDespesa.getDescricao());
            stmt.setDouble(2, oDespesa.getValorDespesa());
            stmt.setDouble(3, oDespesa.getValorpago());
            stmt.setDate(4, new java.sql.Date(oDespesa.getDataDocumento().getTime()));
            stmt.setString(5, oDespesa.getImagemDocumento());
            stmt.setInt(6, oDespesa.getIdDespesa());
            stmt.execute();
            conexao.commit();
            return true;
        } catch(Exception ex){
            try{
                System.out.print("Problema ao altera Despesa ! Erro: "+ex.getMessage());
                ex.printStackTrace();
                conexao.rollback();
            } catch (SQLException e){
                System.out.println("Problemas ao executar rollback"+e.getMessage());
                ex.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Boolean excluit(int numero){
        int idDespesa = numero;
        PreparedStatement stmt = null;
        String sql ="delete from despesa where iddespesa=?";
        try{
            stmt= conexao.prepareStatement(sql);
            stmt.setInt(1, idDespesa);
            stmt.execute();
            conexao.commit();
            return true;
        }catch(Exception ex){
            try{
                System.out.println("Problemas ao excluir a Despesa! Erro:"
                    +ex.getMessage());
                conexao.rollback();
            }catch(SQLException e){
                System.out.println("Problemas ao executar  rolback"+e.getMessage());
                e.printStackTrace();
            }
            return false;
        }
    }

    @Override
    public Object carregar(int numero) {
        int idDespesa = numero;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Despesa oDespesa = null;
        String sql ="select * from despesa where idDespesa=?";
        
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, idDespesa);
            rs=stmt.executeQuery();
            while (rs.next()){
                oDespesa = new Despesa();
                oDespesa.setIdDespesa(rs.getInt("idDespesa"));
                oDespesa.setDescricao(rs.getString("descricao"));
                oDespesa.setValorDespesa(rs.getDouble("valorDespesa"));         
                oDespesa.setValorpago(rs.getDouble("valorpago"));         
                oDespesa.setDataDocumento(rs.getDate("datadocumento"));         
                oDespesa.setImagemDocumento(rs.getString("imagemdocumento"));         
            }
        }catch(Exception ex){
            System.out.println("Problemas ao carregar Despesa! Erro:"+ex.getMessage());
            ex.printStackTrace();
        }
        return oDespesa;
    }

    @Override
    public List<Object> listar() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> resultado = new ArrayList<>();
        Despesa oDespesa = null;
        String sql ="select * from despesa";
         try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()){
                oDespesa = new Despesa();
                oDespesa.setIdDespesa(rs.getInt("idDespesa"));
                oDespesa.setDescricao(rs.getString("descricao"));
                oDespesa.setValorDespesa(rs.getDouble("valorDespesa"));         
                oDespesa.setValorpago(rs.getDouble("valorpago"));         
                oDespesa.setDataDocumento(rs.getDate("datadocumento"));         
                oDespesa.setImagemDocumento(rs.getString("imagemdocumento"));
                resultado.add(oDespesa);
            }
        }catch(Exception ex){
            System.out.println("Problemas ao carregar Despesa! Erro:"+ex.getMessage());
            ex.printStackTrace();
        }
        return resultado;
    }
    
    public String listarJSON(){
        String strJson ="";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> resultado = new ArrayList<>();
        Despesa oDespesa = null;
        String sql ="select + from despesa";
         try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            strJson = "[";
            int i = 0;
            while (rs.next()){
                if (i>0) strJson+=",";
                strJson +="{\"idDespesa\":"+rs.getInt("iddespesa")+","
                        +"{\"descricao\":\""+rs.getString("descricao")+"\","
                        +"{\"dataDocumento\":\""+data2String(rs.getDate("datadocumento"))+"\","
                        +"{\"valorDespesa\":\""+valorDinheiro(rs.getDouble("valorDespesa"),"BR")+"\","
                        +"{\"dataDocumento\":\""+valorDinheiro(rs.getDouble("valorpago"),"BR")+"\",";
                i++;
            }
            strJson += "]";
        }catch(Exception ex){
            System.out.println("Problemas ao Listar Despes!Erro: "+ex.getMessage());
            ex.printStackTrace();
        }
        System.out.println(strJson);
        return strJson;
    }
    
     
}
