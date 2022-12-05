import { Controller } from "@hotwired/stimulus";
import { useClickOutside } from "stimulus-use";

export default class extends Controller {
  static targets = ['userActions', 'usersMenu'];

  connect() {
    useClickOutside(this, { element: this.userActionsTarget, onlyVisible: true });
  }

  clickOutside(event) {
    if (event.target === this.usersMenuTarget) return;

    event.preventDefault();
    this.userActionsTarget.classList.toggle('hidden');
  }

  toggleUserActions() {
    this.userActionsTarget.classList.toggle('hidden');
  }
}
