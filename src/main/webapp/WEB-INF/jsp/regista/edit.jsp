<!doctype html>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<html lang="it">
<head>
	<jsp:include page="../header.jsp" />
	<title>Modifica Elemento</title>
	
	<!-- style per le pagine diverse dalla index -->
    <link href="./assets/css/global.css" rel="stylesheet">
    
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	
	<main role="main" class="container">
	
		<%-- alert con lista errori --%>
		<div class="alert alert-danger ${regista_da_modificare.hasErrors()?'':'d-none'}" role="alert">
			<c:forEach var ="errorItem" items="${regista_da_modificare.errors }">
	        	<ul>
					<li> ${errorItem }</li>	
				</ul>
	      	</c:forEach>
		</div>
		
		<div class="alert alert-danger alert-dismissible fade show ${errorMessage==null?'d-none': ''}" role="alert">
		  ${errorMessage}
		  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		    <span aria-hidden="true">&times;</span>
		  </button>
		</div>
		
		<div class='card'>
		    <div class='card-header'>
		        <h5>Modifica elemento</h5> 
		    </div>
		    <div class='card-body'>

					<h6 class="card-title">I campi con <span class="text-danger">*</span> sono obbligatori</h6>

					<form method="post" action="ExecuteEditRegistaServlet" novalidate="novalidate">
					
						<div class="form-row">
							<div class="form-group col-md-6">
							
								<label>Nome <span class="text-danger">*</span></label>
								<input type="text" name="nome" id="nome" value="${regista_da_modificare.nome}" class="form-control" placeholder="Inserire il nome" required>
								
							</div>
							
							<div class="form-group col-md-6">
							
								<label>Cognome <span class="text-danger">*</span></label>
								<input type="text" name="cognome" id="cognome" value="${regista_da_modificare.cognome}"  class="form-control"  placeholder="Inserire il cognome" required>
								
							</div>
							
							<div class="form-group col-md-6">
							
								<label>NickName <span class="text-danger">*</span></label>
								<input type="text" name="nickName" id="nickName" value="${regista_da_modificare.nickName}"  class="form-control"  placeholder="Inserire il nickName" required>
								
							</div>
						</div>
						
						<div class="form-row">	
							
							<div class="form-group col-md-3">
							
								<label>Data di Nascita<span class="text-danger">*</span></label>
								<fmt:formatDate var="dataDiNascitaParsed" value="${regista_da_modificare.dataDiNascita}" type="date" pattern="yyyy-MM-dd"/>
                        		<input class="form-control" id="dataDiNascita" value="${dataDiNascitaParsed}" type="date" placeholder="dd/MM/yyyy"
                            		   title="formato : gg/mm/aaaa"  name="dataDiNascita" required>
                            		
							</div>
							
							<div class="form-group col-md-3">
								<label for="sesso">Sesso <span class="text-danger">*</span></label>
							    <select class="form-control" id="sesso" name="sesso"  required>
							    	<option value="" selected> - Selezionare - </option>
							      	<option value="MASCHIO" ${regista_da_modificare.sesso == 'MASCHIO'?'selected':''} >M</option>
							      	<option value="FEMMINA" ${regista_da_modificare.sesso == 'FEMMINA'?'selected':''} >F</option>
							    </select>
							</div>
							
							
						</div>
						
						<input type="hidden" name="idRegista" value="${regista_da_modificare.id}">	
						<button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary">Conferma</button>
						<a class="btn btn-secondary" href="ListAutomobiliServlet">Annulla</a>

					</form>

		    
		    
			<!-- end card-body -->			   
		    </div>
		</div>	
	
	
	<!-- end container -->	
	</main>
	<jsp:include page="../footer.jsp" />
	
</body>
</html>l>