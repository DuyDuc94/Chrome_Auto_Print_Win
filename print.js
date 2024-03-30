
let isChrome = false;
let isConnectPrinter = false;
let isAutoPrint = false;
let autoPrintInterval = null;
const tableBody = document.getElementById('test-content')

const getBrowser = () => {
  const detailBrowser = navigator.userAgent;
  isChrome = detailBrowser.includes("Chrome") && navigator.vendor.includes("Google Inc");
  document.getElementById('is-chrome').innerHTML = isChrome;
  document.getElementById('browser-detail').innerHTML = detailBrowser;
}

const checkPrinter = () => {
  isConnectPrinter = navigator.connection.saveData === true;
  document.getElementById('check-printer').innerHTML = isConnectPrinter;
}

document.getElementById('toggle-print').addEventListener('click', () => {
  startAutoPrint();
});
const startAutoPrint = () => {
  isAutoPrint = !isAutoPrint;
  if (isChrome && isConnectPrinter) {
    document.getElementById('toggle-print').innerHTML = isAutoPrint ? "Stop Auto Print" : "Start Auto Print";
    if(isAutoPrint) {
      autoPrintInterval = setInterval(testAutoPrint, 5000);
    } else {
      clearInterval(autoPrintInterval);
    }
  } else {
    alert("Must use Chrome and connect printer to print!");
  }
}

setInterval(() => {
  if (tableBody.children.length >= 5) {
    clearInterval(autoPrintInterval);
  }
}, 1000)

const testAutoPrint = async () => {
  const newWindow = getPrintWindow(200, 200, "Test print");
  const data = `test data: ${Math.random()}`;
  const html = `<!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Auto Print Chrome</title>
  </head>
  <body>
    ${data}
  </body>
  </html>`;
  await doPrint(newWindow, html).then((result) => {
    const newTr = document.createElement('tr');
    newTr.innerHTML = `<td>${Math.random()}</td> <td>${result}</td>`;
    tableBody.appendChild(newTr);
  }).catch((err) => {
    console.log(err);
  });
}

const getPrintWindow = (w, h, title) => {
  const dualScreenLeft = window.screenLeft !== undefined ? window.screenLeft : window.screenX;
  const dualScreenTop = window.screenTop !== undefined ? window.screenTop : window.screenY;

  const width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
  const height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

  const systemZoom = width / window.screen.availWidth;
  const left = (width - w) / 2 / systemZoom + dualScreenLeft
  const top = (height - h) / 2 / systemZoom + dualScreenTop
  const newWindow = window.open("/", title,
    `
    scrollbars=yes,
    width=${width}, 
    height=${height}, 
    top=${top}, 
    left=${left}
    `
  )
  return newWindow;
}

const doPrint = async (newWindow, html) => {
  newWindow.document.write(html)
  newWindow.print()
  const successPrinted = false;
  newWindow.onafterprint = () => {
    successPrinted = true;
  }
  newWindow.document.close()
  newWindow.close()
  return successPrinted;
}

getBrowser();
checkPrinter();