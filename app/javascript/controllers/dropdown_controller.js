import { Controller } from "@hotwired/stimulus";
import { useClickOutside } from "stimulus-use";

export default class extends Controller {
  static targets = ['menu', 'profile'];

  connect() {
    useClickOutside(this, { element: this.menuTarget, onlyVisible: true });
  }

  clickOutside(event) {
    if (event.target === this.profileTarget) return;

    event.preventDefault();
    this.menuTarget.classList.toggle('hidden');
  }

  toggle() {
    this.menuTarget.classList.toggle('hidden');
  }
}
