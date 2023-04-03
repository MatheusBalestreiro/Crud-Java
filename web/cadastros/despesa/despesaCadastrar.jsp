<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<jsp:include page="/header.jsp"/>
<jsp:include page="/menu.jsp"/>

<div class="container-fluid">
    <!-- Page Heading -->
    <h1 class="h3 mb-2 mt-4 text-gray-800">Despesas</h1>
    <p class="mb-4">Formulário de Cadastro</p>

    <a class="btn btn-secondary mb-4" href="${pageContext.request.contextPath}/DespesaListar">
        <i class="fas fa-undo-alt"></i>
        <strong>Voltar</strong>
    </a>
    <div class="row">
        <!-- Imagem do Documento --> 
        <div class="col">
            <div class="card shadow mb-4"> 
                <div class="card-body">
                    <div class="form-group">
                        <center>
                            <img alt="imagem" class="img-thumbnail" 
                                 src="${despesa.imagemDocumento}" 
                                 name="target" id="target" width="350" heigth="200">
                            <br></br>
                            <input type="file" id="gallery-photo-add" 
                                   class="inputfile" onchange="uploadFile();"/>
                            <label for="gallery-photo-add" class="btn btn-success mt-4">
                                <i class="fas fa-file-upload"></i> 
                                Selecionar Documento...
                            </label>
                        </center>
                    </div>
                </div>
            </div>
        </div>
        <!-- Campos de cadastramento -->        
        <div class="col-lg-9">
            <div class="card shadow mb-4">
                <div class="card-body">
                    <div class="form-group">
                        <label>Id</label>
                        <input class="form-control" type="text" name="idDespesa" id="iddespesa" 
                               value="${despesa.idDespesa}" readonly="readonly"/>
                    </div>
                    <div class="form-group">
                        <label>Descrição da Despesa</label>
                        <input class="form-control" type="text" name="descricao" id="descricao" 
                               value="${despesa.descricao}" size="100" maxlength="100"/>
                    </div>
                    <div class="form-group">
                        <div class="form-line row">
                            <div class="col-sm">
                                <label>Data da Despesa</label>
                                <input class="form-control" type="date" name="datadocumento" id="datadocumento" 
                                       value="${despesa.dataDocumento}"/>
                            </div>
                            <div class="col-sm">
                                <label>Valor da Despesa</label>
                                <input class="form-control" type="text" style="text-align:right;" 
                                           name="valordespesa" id="valordespesa" 
                                           value="<fmt:formatNumber value='${despesa.valorDespesa}' type='currency'/>" />
                            </div>
                            <div class="col-sm">
                                <label>Valor Pago</label>
                                <input class="form-control" type="text" style="text-align:right;" 
                                           name="valorpago" id="valorpago" 
                                           value="<fmt:formatNumber value='${despesa.valorpago}' type='currency'/>" />
                            </div> 
                        </div>
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
    $(document).ready(function () {
        console.log("entrei na ready do documento");
        $("#valordespesa").maskMoney({
            prefix: 'R$',
            suffix: '',
            allowZero: false,
            allowNegative: true,
            allowEmpty: false,
            doubleClickSelection: true,
            selectAllOnFocus: true,
            thousands: '.',
            decimal: ",",
            precision: 2,
            affixesStay: true,
            bringCareAtEndOnFocus: true
        })
        
        $("#valorpago").maskMoney({
            prefix: 'R$',
            suffix: '',
            allowZero: false,
            allowNegative: true,
            allowEmpty: false,
            doubleClickSelection: true,
            selectAllOnFocus: true,
            thousands: '.',
            decimal: ",",
            precision: 2,
            affixesStay: true,
            bringCareAtEndOnFocus: true
        })
    })
    
    function validarCampos() {
        console.log("entrei na validação de campos");
        if (document.getElementById("descricao").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a descrição da despesa!',
                showConfirmButton: false,
                timer: 1000
            });
            $("#descricao").focus();
        } else if (document.getElementById("datadocumento").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a Data da despesa!',
                showConfirmButton: false,
                timer: 1000
            });
            $("#datadocumento").focus();
        } else if (document.getElementById("valordespesa").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique o valor da despesa!',
                showConfirmButton: false,
                timer: 1000
            });
            $("#valordespesa").focus();
        } else {
            gravarDados();
        }
    }
    
    function gravarDados() {
        console.log("Gravando dados ....");
        var target = document.getElementById("target").src;
        $.ajax({
            type: 'post',
            url: 'DespesaCadastrar',
            data: {
                iddespesa: $('#iddespesa').val(),
                descricao: $('#descricao').val(),
                datadocumento: $('#datadocumento').val(),
                valordespesa: $('#valordespesa').val(),
                valorpago: $('#valorpago').val(),
                imagemdocumento: target
            },
            success:
                    function (data) {
                        console.log("reposta servlet->");
                        console.log(data);
                        if (data == 1) {
                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                title: 'Sucesso',
                                text: 'Despesa gravada com sucesso!',
                                showConfirmButton: true,
                                timer: 1000
                            }).then(function(){
                                window.location.href = "${pageContext.request.contextPath}/DespesaListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'Não foi possosivel gravar a despesa!',
                                showConfirmButton: true,
                                timer: 1000
                            }).then(function(){
                                window.location.href = "${pageContext.request.contextPath}/DespesaListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/DespesaListar";
                    }
        });
    }
    
    function uploadFile() {
        //pega o componente html image 
        var target = document.getElementById("target");
        //limpa o image
        target.src = "";
        //abre a janela para seleção do arquivo.
        var file = document.querySelector("input[type='file']").files[0];
        //verifica se o arquivo existe
        if (file) {
            //faz a leitura do arquivo da imagem
            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onloadend = function () {
                //atribui a imagem do arquivo ao componente html image
                target.src = reader.result;
            };
        } else {
            target.src = "";
        }
    }
    
</script>   
<jsp:include page="/footer.jsp"/>