import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { budget: Number }
  static targets = ["driver1", "driver2", "car", "engineer", "remaining", "submit"]

  connect() {
    this.calculate()
  }

  calculate() {
    const driver1Price = this.getPrice(this.driver1Target)
    const driver2Price = this.getPrice(this.driver2Target)
    const carPrice = this.getPrice(this.carTarget)
    const engineerPrice = this.getPrice(this.engineerTarget)

    const totalCost = driver1Price + driver2Price + carPrice + engineerPrice
    const remaining = this.budgetValue - totalCost

    this.remainingTarget.textContent = this.formatCurrency(remaining)

    if (remaining < 0) {
      this.remainingTarget.classList.add("text-red-600")
      this.remainingTarget.classList.remove("text-green-600")
      this.submitTarget.disabled = true
      this.submitTarget.classList.add("opacity-50", "cursor-not-allowed")
    } else {
      this.remainingTarget.classList.remove("text-red-600")
      this.remainingTarget.classList.add("text-green-600")
      this.submitTarget.disabled = false
      this.submitTarget.classList.remove("opacity-50", "cursor-not-allowed")
    }
  }

  getPrice(selectTarget) {
    if (!selectTarget || selectTarget.selectedIndex === -1) return 0
    const selectedOption = selectTarget.options[selectTarget.selectedIndex]
    return parseFloat(selectedOption.dataset.price) || 0
  }

  formatCurrency(amount) {
    return "€" + Number(amount).toLocaleString('en-US')
  }
}
