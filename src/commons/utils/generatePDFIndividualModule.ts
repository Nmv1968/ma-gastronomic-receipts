// import puppeteer from 'puppeteer';
// import { getReportDate } from './general';
// export async function createPDFIndividualModule(
//   bodyDocumento: any,
//   dataAdicional: any,
// ) {

//   // const { user } = dataAdicional;
//   const browser = await puppeteer.launch({
//     // headless: true,
//     headless: 'new' as 'shell',
//     args: ['--no-sandbox', '--disable-setuid-sandbox'],
//   });
//   const fechaActual = getReportDate();
//   const page = await browser.newPage();
//   //  await page.setViewport({width: 1080, height: 1024});
//   await page.setContent(`
//     <style>
//     @page
//     {
//         size: A4 ${dataAdicional.orientation == 'H' ? 'landscape' : 'portrait'};
//         margin: 30px 30px 30px 30px;
//     }
//     .bodered{
//         border: 1px solid black;
//         border-collapse: collapse;
//         font-size: 12px;
//     }
//     .fs-12{
//         font-size: 12px;
//     }
//     .fs-10{
//         font-size: 10px;
//     }
//     .fs-8{
//         font-size: 8px;
//     }
//     .fs-7{
//         font-size: 7px;
//     }
//     .rounded-60{
//         border-radius: 20px
//     }
//     </style>
//     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
//     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
//     <page   backimgx="center"  backimgw="100%" backleft="15mm"  backright="15mm" backtop="25mm" backbottom="10mm" >
//     <page_header>
//     </page_header>


//         ${bodyDocumento}

//     </page>
//      `);
//   const pdf = await page.pdf({
//     // path: 'example.pdf',
//     format: 'A4',
//     displayHeaderFooter: true,
//     headerTemplate: '<div/>',
//     footerTemplate:
//       '<div style="text-align: center; width: 297mm;font-size: 8px;"><span style="margin-left: 6cm">Generado el : '+
//       fechaActual +
//       '</span><span style="text-align: right;  margin-left: 6cm"><span class="pageNumber"></span> of <span class="totalPages"></span></span></div>',
//     preferCSSPageSize: true,
//   });

//   return pdf;
// }
