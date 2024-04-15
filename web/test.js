function test(fName, lName, phoneNumber, email) {
    console.log(fName);


  let vCardData = `BEGIN:VCARD
VERSION:3.0
N:${lName};${fName}
ORG:
TEL:${phoneNumber}
EMAIL:${email}
END:VCARD`;

  console.log(vCardData);
  const blob = new Blob([vCardData], { type: 'text/vcard' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = "name" + '.vcf';
  a.style.display = 'inline-grid;'; // Düğmeyi gizle
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
}

window.logger = (flutter_value) => {
    console.log({ js_context: this, flutter_value });
 }