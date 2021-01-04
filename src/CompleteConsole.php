<?php

/**
 * This file is part of giroapp-completion-plugin.
 *
 * giroapp-completion-plugin is free software: you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * giroapp-completion-plugin is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with giroapp-completion-plugin. If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright 2020-21 Hannes Forsgård
 */

declare(strict_types=1);

namespace byrokrat\giroappcompletionplugin;

use byrokrat\giroapp\Console\ConsoleInterface;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

final class CompleteConsole implements ConsoleInterface
{
    /**
     * @var Command
     */
    private $command;

    public function configure(Command $command): void
    {
        $this->command = $command;

        $command
            ->setName('_complete')
            ->setHidden(true)
            ->addArgument('line', InputArgument::OPTIONAL, '', '')
            ->addArgument('cursor', InputArgument::OPTIONAL, '', '0')
            ->addArgument('to-replace', InputArgument::OPTIONAL, '', '')
            ->addOption('generate-bash-script', null, InputOption::VALUE_NONE)
            ->addOption('app-name', null, InputOption::VALUE_REQUIRED)
        ;
    }

    public function execute(InputInterface $input, OutputInterface $output): void
    {
        $comphlete = new ExecutableComphleteCommand();
        $comphlete->setApplication($this->command->getApplication());
        $comphlete->execute($input, $output);
    }
}
