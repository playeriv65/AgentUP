import fs from 'node:fs';
import {bundle} from '@remotion/bundler';
import {selectComposition,renderMedia,renderStill} from '@remotion/renderer';
import path from 'node:path';
fs.mkdirSync(path.resolve('../outputs'),{recursive:true});
const serveUrl=await bundle({entryPoint:path.resolve('src/index.tsx')});
const composition=await selectComposition({serveUrl,id:'MatrixFourViews'});
if(process.argv.includes('--stills')) {
 for(const [name,frame] of [['intro',180],['dot',650],['outer',1650],['row',2600],['column',3500],['summary',3900]]) {
  await renderStill({serveUrl,composition,frame,output:path.resolve(`../outputs/${name}.png`)});
  console.log(`Still ${name}`);
 }
} else {
 let last=-1;
 await renderMedia({serveUrl,composition,codec:'h264',crf:18,concurrency:6,outputLocation:path.resolve('../outputs/矩阵乘法-四种理解.mp4'),onProgress:({progress})=>{const p=Math.floor(progress*100);if(p>=last+10){last=p;console.log(`Rendering ${p}%`);}}});
 console.log('Finished');
}
