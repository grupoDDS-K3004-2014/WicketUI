package uiWicket

import org.apache.wicket.markup.html.WebPage
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import dominioModelo.Nota
import dominioModelo.Materia
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.form.TextField
import org.apache.wicket.markup.html.form.CheckBox
import org.uqbar.wicket.xtend.XButton
import org.apache.wicket.markup.html.panel.FeedbackPanel

class EditarNotaPage extends WebPage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	private final MateriasPage mainPage
	private Nota nota
	private Materia materia
	private boolean alta
	private Nota notaClon

	new(Materia materiaSeleccionada, Nota notaAEditar, MateriasPage mainPage, boolean alta) {
		this.mainPage = mainPage
		this.materia = materiaSeleccionada
		this.nota = notaAEditar
		this.alta = alta
		notaClon = nota.clone as Nota
		this.addChild(new Label("titulo", if(this.alta) "Nueva nota" else "Editar Nota"))
		val editarNotaForm = new Form<Nota>("editarNota", this.nota.asCompoundModel)
		this.agregarCamposEdicion(editarNotaForm)
		this.agregarAcciones(editarNotaForm)
		this.addChild(editarNotaForm)
	}

	def agregarCamposEdicion(Form<Nota> form) {
		form.addChild(new TextField<String>("fecha"))
		form.addChild(new TextField<String>("descripcion"))
		form.addChild(new CheckBox("aprobado"))
		form.addChild(new FeedbackPanel("feedbackPanel"))
	}

	def agregarAcciones(Form<Nota> form) {
		form.addChild(
			new XButton("aceptar").onClick = [ |
				nota.validate()
				aceptar()
			])
		form.addChild(
			new XButton("volver") => [
				onClick = [ |
					nota.copiarValoresDe(notaClon)
					volver()
				]
			])
	}

	def aceptar() {
		if (this.alta) {
			materia.agregarNota(nota)
		}
		volver()
	}

	def volver() {
		responsePage = mainPage
	}

}
