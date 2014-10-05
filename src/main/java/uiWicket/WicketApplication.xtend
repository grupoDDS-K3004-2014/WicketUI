package uiWicket

import org.apache.wicket.protocol.http.WebApplication
import org.uqbar.commons.utils.ApplicationContext
import dominioModelo.HomeMaterias
import dominioModelo.Materia
import uiWicket.MateriasPage

class WicketApplication extends WebApplication {
	
	override protected init() {
		super.init()
		ApplicationContext.instance.configureSingleton(Materia, new HomeMaterias)
	}
	
	override getHomePage() {
		return MateriasPage
	}
	
}