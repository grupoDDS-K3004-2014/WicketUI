package uiWicket

import dominioModelo.Materia
import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.form.TextField
import org.apache.wicket.markup.html.panel.FeedbackPanel

//import org.uqbar.commons.model.UserException
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.apache.wicket.model.CompoundPropertyModel

class AgregarMateriaPage extends WebPage {

	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	private final Materia materia
	private final MateriasPage mainPage

	new(Materia materiaAEditar, MateriasPage mainPage) {
		this.mainPage = mainPage
		this.materia = materiaAEditar
		val materiasForm = new Form<Materia>("nuevaMateriaForm", new CompoundPropertyModel<Materia>(this.materia))
		this.agregarCamposEdicion(materiasForm)
		this.agregarAcciones(materiasForm)
		this.addChild(materiasForm)
	}

	def void agregarAcciones(Form<Materia> parent) {
		parent.addChild(
			new XButton("aceptar").onClick = [ |
				materia.validar()
				Materia.home.create(materia)
				mainPage.materiaAppModel.materiaSeleccionada = materia
				volver()
			])
		parent.addChild(
			new XButton("cancelar") => [
				onClick = [|volver]
			])
	}

	def volver() {
		mainPage.obtenerMaterias()
		responsePage = mainPage
	}

	def agregarCamposEdicion(Form<Materia> parent) {
		parent.addChild(new TextField<String>("nombre"))
		parent.addChild(new FeedbackPanel("feedbackPanel"))
	}

}
