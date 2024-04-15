function openLink(url) {
    window.open(url, '_blank').focus();
}

window.logger = (flutter_value) => {
    console.log({ openLink: this, flutter_value });
 }