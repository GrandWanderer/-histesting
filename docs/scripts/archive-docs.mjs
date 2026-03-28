import { existsSync, mkdirSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import { resolve } from 'node:path';

const referenceDir = resolve(process.cwd(), 'generated-docs', 'reference');
const archiveDir = resolve(process.cwd(), 'generated-docs', 'archive');
const archivePath = resolve(archiveDir, 'reference-docs.tgz');

if (!existsSync(referenceDir)) {
    throw new Error('Documentation has not been generated yet. Run "npm run docs:generate" first.');
}

mkdirSync(archiveDir, { recursive: true });

execFileSync('tar', [
    '-czf',
    archivePath,
    '-C',
    resolve(process.cwd(), 'generated-docs'),
    'reference'
], {
    stdio: 'inherit'
});
