<?php

namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class LoanSimulationType extends AbstractType
{
    public function buildForm(
        FormBuilderInterface $builder,
        array $options
    ): void {
        $builder
            ->add('amount', NumberType::class, [
                'label' => 'Monto solicitado',
            ])
            ->add('termMonths', IntegerType::class, [
                'label' => 'Plazo (meses)',
            ])
            ->add('interestRate', NumberType::class, [
                'label' => 'Interés mensual (%)',
            ])
            ->add('firstDueDate', DateType::class, [
                'label' => 'Fecha primera cuota',
                'widget' => 'single_text',
            ]);
    }

    public function configureOptions(
        OptionsResolver $resolver
    ): void {
        $resolver->setDefaults([]);
    }
}
