<!doctype html>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>


<html lang="it">
<head>
	<jsp:include page="../header.jsp" />
	<title>Elimina elemento</title>
	
	<!-- style per le pagine diverse dalla index -->
    <link href="${pageContext.request.contextPath }/assets/css/global.css" rel="stylesheet">
    
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	
	<main role="main" class="container">
	
	
		
		<div class='card'>
		    <div class='card-header'>
		        Visualizza dettaglio del regista da eliminare
		    </div>
		
		    <div class='card-body'>
		    	<dl class="row">
				  <dt class="col-sm-3 text-right">Codice</dt>
				  <dd class="col-sm-9">${elimina_regista_attr.nome}</dd>
		    	</dl>
		    	
		    	<dl class="row">
				  <dt class="col-sm-3 text-right">Descrizione:</dt>
				  <dd class="col-sm-9">${elimina_regista_attr.cognome}</dd>
		    	</dl>
		    	
		    	<dl class="row">
				  <dt class="col-sm-3 text-right">Prezzo:</dt>
				  <dd class="col-sm-9">${elimina_regista_attr.nickName}</dd>
		    	</dl>
		    	
		    	<dl class="row">
				  <dt class="col-sm-3 text-right">Data di Pubblicazione:</dt>
				  <dd class="col-sm-9"><fmt:formatDate pattern = "dd/MM/yyyy" 
         value = "${elimina_regista_attr.dataDiNascita}" /></dd>
		    	</dl>
		    	
		    	<dl class="row">
				  <dt class="col-sm-3 text-right">Sesso:</dt>
				  <dd class="col-sm-9">${elimina_regista_attr.sesso}</dd>
		    	</dl>
		    	
		    </div>
		    
		    <div class='card-footer'>
		    
		    	<form action="executedelete" method="post"   >
			        <a href="${pageContext.request.contextPath }/regista/" class='btn btn-outline-secondary' style='width:80px'>
			            <i class='fa fa-chevron-left'></i> Back
			        </a>

		        	<input type="hidden"   name="idRegista"   value="${elimina_regista_attr.id }">
		        	<button type="submit" class='btn btn-outline-secondary' style='color: black;background-color: red'>Elimina</button>

		        </form>
		        
		        
		    </div>
		    
		    
		 </div>	
	
	
	
	<!-- end main container -->	
	</main>
	<jsp:include page="../footer.jsp" />
	
</body>
</html>