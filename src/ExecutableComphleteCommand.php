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

declare(strict_types = 1);

namespace byrokrat\giroappcompletionplugin;

use hanneskod\comphlete\Symfony\ComphleteCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

final class ExecutableComphleteCommand extends ComphleteCommand
{
    public function execute(InputInterface $input, OutputInterface $output): int
    {
        return parent::execute($input, $output);
    }
}
