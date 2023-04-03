package br.com.curso.model;

import br.com.curso.utils.Conversao;
import java.util.Date;

public class Despesa {
    private int idDespesa;
    private String descricao;
    private Date dataDocumento;
    private double valorDespesa;
    private double valorpago;
    private String imagemDocumento;

    public Despesa() {
    idDespesa = 0;
    descricao = "";
    valorDespesa = 0;
    valorpago = 0; 
    dataDocumento = Conversao.dataAtual();
    }

    public Despesa(int idDespesa, String descricao, Date dataDocumento, double valorDespesa, double valorpago, String imagemDocumento) {
        this.idDespesa = idDespesa;
        this.descricao = descricao;
        this.dataDocumento = dataDocumento;
        this.valorDespesa = valorDespesa;
        this.valorpago = valorpago;
        this.imagemDocumento = imagemDocumento;
    }

    
    public int getIdDespesa() {
        return idDespesa;
    }

    public void setIdDespesa(int idDespesa) {
        this.idDespesa = idDespesa;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Date getDataDocumento() {
        return dataDocumento;
    }

    public void setDataDocumento(Date dateDocumento) {
        this.dataDocumento = dateDocumento;
    }

    public double getValorDespesa() {
        return valorDespesa;
    }

    public void setValorDespesa(double valorDespesa) {
        this.valorDespesa = valorDespesa;
    }

    public double getValorpago() {
        return valorpago;
    }

    public void setValorpago(double valorpago) {
        this.valorpago = valorpago;
    }

    public String getImagemDocumento() {
        return imagemDocumento;
    }

    public void setImagemDocumento(String imagemDocumento) {
        this.imagemDocumento = imagemDocumento;
    }
    
    
}
