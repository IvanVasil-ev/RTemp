import { ajax } from '@rails/ujs';
import CheckboxSelectAll from 'stimulus-checkbox-select-all'


export default class extends CheckboxSelectAll {
  connect() {
    super.connect();

    this.checked;
    this.unchecked;
  }

  selectCheckbox(el) {
    const disabledEl = Boolean(el.target.dataset?.disablecheck !== undefined);
    const elem = el.target.closest('tr').children[0].children[0].children[0];
    const checked = elem.checked;
    const allCheckboxes = document.querySelectorAll('#checkbox');
    const genCheckbox = document.getElementById('checkbox-select-all');
    const allCheckboxesToBool = (listNodes) => Array.from(listNodes).map((cb) => cb.checked);

    if ((el.target !== elem) && !disabledEl) {
      elem.checked = !checked;
    }

    const isAllChecked = allCheckboxesToBool(allCheckboxes).every((el) => el === true);
    const isSomeChecked = allCheckboxesToBool(allCheckboxes).some((el) => el === true);

    if (isAllChecked) {
      genCheckbox.checked = true;
      genCheckbox.indeterminate = false;
    } else if (!isAllChecked && isSomeChecked) {
      genCheckbox.indeterminate = true;
      genCheckbox.checked = false;
    } else {
      genCheckbox.checked = false;
      genCheckbox.indeterminate = false;
    }
  }

  getCheckedUserIds() {
    return this.checked.map((el) => Number(el.value));
  }

  deleteUsers() {
    ajax({
      type: 'delete',
      url: `/users?id=${this.getCheckedUserIds().join(',')}`,
    })
  }
}
