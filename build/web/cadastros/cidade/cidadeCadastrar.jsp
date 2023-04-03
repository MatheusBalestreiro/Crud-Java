<%@taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<jsp:include page="/header.jsp"/>
<jsp:include page="/menu.jsp"/>

<div class="container-fluid">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 mt-4 text-gray-800">Cidade</h1>
    <p class="mb-4">Formulário de Cadastro</p>

    <a class="btn btn-secondary mb-4" href="${pageContext.request.contextPath}/CidadeListar">
        <i class="fas fa-undo-alt"></i>
        <strong>Voltar</strong>
    </a>
    <div class="row">
        <!-- Campos de cadastramento -->        
        <div class="col-lg-9">
            <div class="card shadow mb-4">
                <div class="card-body">
                    <div class="form-group">
                        <label>Id</label>
                        <input class="form-control" type="text" name="idCidade" id="idcidade" 
                               value="${cidade.idCidade}" readonly="readonly"/>
                    </div>
                    <div class="form-group">
                        <label>Nome Cidade</label>
                        <input class="form-control" type="text" name="nomecidade" id="nomecidade" 
                               value="${cidade.nomeCidade}" size="100" maxlength="100"/>
                    </div>
                    <div class="form-group">
                        <label>Sigla Estado</label>
                            <select class="form-select"  aria-label="Default select example" >
                                <option value="">Selecione</option>
                                    <c:forEach var="estado" items="${estados}">
                                        <option id="idestado" value="${estado.idEstado}" 
                                            ${cidade.estado.idEstado == estado.idEstado ? "selected" : ""}>
                                         ${estado.siglaEstado}
                                </option>
                                    </c:forEach>
                            </select>
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="situacao" id="situacao" value="${cidade.situacao}" readonly="readonly" />
                    </div>
                    
                    <!-- Botão de Confirmalario --> 
                    <div class="form-group">
                        <button class="btn btn-success" type="submit" id="submit" onclick="validarCampos()">
                            Salvar</button>
                    </div> 
                </div>
            </div>
        </div>
    </div>
</div>
                               
<script>
        function validarCampos() {
        console.log("entrei na validação de campos");
        if (document.getElementById("nomecidade").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o nome da cidade!',
                showConfirmButton: false,
                timer: 1000
            });
            $("#nomecidade").focus();
        } else {
            gravarDados();
        }
    }
    
    function gravarDados() {
        console.log("Gravando dados ....");
        $.ajax({
            type: 'post',
            url: 'CidadeCadastrar',
            data: {
                idcidade: $('#idcidade').val(),
                nomecidade: $('#nomecidade').val(),
                idestado: $('#idestado').val(),
                situacao: $('#situacao').val(),
            },
            success:
                    function (data) {
                        console.log("reposta servlet->");
                        if (data == 1) {
                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                title: 'Sucesso',
                                text: 'Cidade gravada com sucesso!',
                                showConfirmButton: true,
                                timer: 1000
                            }).then(function(){
                                window.location.href = "${pageContext.request.contextPath}/CidadeListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possosivel gravar a Cidade!',
                                showConfirmButton: true,
                                timer: 1000
                            }).then(function(){
                                window.location.href = "${pageContext.request.contextPath}/CidadeListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/CidadeListar";
                    }
        });
    }
</script>                   
                               
<%@include file="/footer.jsp"%>