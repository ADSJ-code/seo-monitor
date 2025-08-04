import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "status" ]
  static values = { url: String }

  async check() {
    this.statusTarget.textContent = "A verificar..."
    this.statusTarget.style.color = "orange"

    const response = await fetch(this.urlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
      },
    });

    if (response.ok) {
      this.statusTarget.textContent = "Verificação enviada com sucesso!";
      this.statusTarget.style.color = "green";

      // Opcional: Avisa para recarregar a página para ver o resultado
      setTimeout(() => {
        this.statusTarget.textContent = "Recarregue a página para ver o novo resultado.";
      }, 2000);

    } else {
      this.statusTarget.textContent = "Ocorreu um erro ao verificar.";
      this.statusTarget.style.color = "red";
    }
  }
}