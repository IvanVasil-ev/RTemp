import { Controller } from "@hotwired/stimulus";
import { useClickOutside } from "stimulus-use";

export default class extends Controller {
  static targets = ['sidebarMenu', 'sidebarProfile'];

  connect() {
    useClickOutside(this, { element: this.sidebarMenuTarget, onlyVisible: true });
  }

  clickOutside(event) {
    if (event.target === this.sidebarProfileTarget) return;

    event.preventDefault();
    this.sidebarMenuTarget.classList.toggle('hidden');
  }

  toggleSidebarMenu() {
    this.sidebarMenuTarget.classList.toggle('hidden');
  }
}
