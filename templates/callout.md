<%*
const calloutTypes = [
    { name: 'abstract', icon: '' },
    { name: 'attention', icon: '' },
    { name: 'bug', icon: '' },
    { name: 'caution', icon: '' },
    { name: 'check', icon: '' },
    { name: 'cite', icon: '' },
    { name: 'danger', icon: '' },
    { name: 'done', icon: '' },
    { name: 'error', icon: '' },
    { name: 'example', icon: '' },
    { name: 'fail', icon: '' },
    { name: 'failure', icon: '' },
    { name: 'faq', icon: '' },
    { name: 'help', icon: '' },
    { name: 'hint', icon: '' },
    { name: 'important', icon: '' },
    { name: 'info', icon: '' },
    { name: 'missing', icon: '' },
    { name: 'note', icon: '' },
    { name: 'question', icon: '' },
    { name: 'quote', icon: '' },
    { name: 'success', icon: '' },
    { name: 'summary', icon: '' },
    { name: 'tip', icon: '' },
    { name: 'tldr', icon: '' },
    { name: 'todo', icon: '' },
    { name: 'warning', icon: '' },

    { name: 'axm', type: 'thm', icon: '', alias: 'axiom' },
    { name: 'def', type: 'thm', icon: '', alias: 'definition', },
    { name: 'lem', type: 'thm', icon: '', alias: 'lemma' },
    { name: 'prp', type: 'thm', icon: '', alias: 'proposition' },
    { name: 'thm', type: 'thm', icon: '', alias: 'theorem' },
    { name: 'cor', type: 'thm', icon: '', alias: 'corollary' },
    { name: 'clm', type: 'thm', icon: '', alias: 'claim' },
    { name: 'asm', type: 'thm', icon: '', alias: 'assumption' },
    { name: 'exm', type: 'thm', icon: '', alias: 'THM example' },
    { name: 'exr', type: 'thm', icon: '', alias: 'exercise' },
    { name: 'cnj', type: 'thm', icon: '', alias: 'conjecture' },
    { name: 'hyp', type: 'thm', icon: '', alias: 'hypothesis' },
    { name: 'rmk', type: 'thm', icon: '', alias: 'remark' },
];

const foldingTypes = [
    { text: '-', desc: 'Closed by default' },
    { text: '+', desc: 'Open by default' },
    { text: '',  desc: 'Always open' },
];

const calloutType = await tp.system.suggester(calloutTypes.map(({ name, icon, alias }) => `${icon ? icon + ' ' : ''}${name}${alias ? ` (${alias})` : ''}`), calloutTypes);
if (calloutType === null) return;

let indices = [0, 1, 2];
if (calloutType.name === 'exm') {
    indices = [1, 0, 2];
} else if (calloutType.type === 'thm') {
    indices = [2, 0, 1];
}

const texts = indices.map(i => foldingTypes[i].text);
const descs = indices.map(i => foldingTypes[i].desc);
const folding = await tp.system.suggester(descs, texts);
if (folding === null) return;

tR += `> [!${calloutType.name}]${folding} <` + '% ' + 'tp.file.cursor()' + ' %' + '>';
%>
