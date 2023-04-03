<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<jsp:include page="/header.jsp"/>
<jsp:include page = "/menu.jsp"/>

<div class="container-fluid">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 mt-4 text-gray-800">Estado</h1>
    <p class="mb-4">Formulário de Cadastro</p>

    <a class="btn btn-secondary mb-4" href="${pageContext.request.contextPath}/EstadoListar">
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
                        <input class="form-control" type="text" name="idEstado" id="idestado" 
                               value="${estado.idEstado}" readonly="readonly"/>
                    </div>
                    <div class="form-group">
                        <label>Nome Estado</label>
                        <input class="form-control" type="text" name="nomeestado" id="nomeestado" 
                               value="${estado.nomeEstado}" size="100" maxlength="100"/>
                    </div>
                    <div class="form-group">
                        <label>Sigla Estado</label>
                        <input class="form-control" type="text" name="siglaestado" id="siglaestado" 
                               value="${estado.siglaEstado}" size="100" maxlength="100"/>
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
        if (document.getElementById("nomeestado").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o nome do estado!',
                showConfirmButton: false,
                timer: 1000
            });
            $("#nomeestado").focus();
        } else if (document.getElementById("siglaestado").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a sigla do Estado!',
                showConfirmButton: false,
                timer: 1000
            });
            $("#siglaestado").focus();
        } else {
            gravarDados();
        }
    }
    
    function gravarDados() {
        console.log("Gravando dados ....");
        $.ajax({
            type: 'post',
            url: 'EstadoCadastrar',
            data: {
                idestado: $('#idestado').val(),
                nomeestado: $('#nomeestado').val(),
                siglaestado: $('#siglaestado').val(),
            },
            success:
                    function (data) {
                        console.log("reposta servlet->");
                        if (data == 1) {
                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                title: 'Sucesso',
                                text: 'Estado gravado com sucesso!',
                                showConfirmButton: true,
                                timer: 1000
                            }).then(function(){
                                window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possivel gravar o Estado!',
                                showConfirmButton: true,
                                timer: 1000
                            }).then(function(){
                                window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                    }
        });
    }
</script>                   
<%@include file="/footer.jsp" %>