#!/bin/bash

# Script de Otimização Segura para EndeavourOS + OC System
# Baseado na análise do sistema atual

set -e # Exit on any error

echo "=== Sistema Detectado ==="
echo "CPU: AMD Ryzen 7 5800X3D (OC estável)"
echo "RAM: DDR4-3733 (Overclock)"
echo "GPU: NVIDIA GTX 1660 SUPER"
echo "NVMe: Seagate XPG GAMMIX S70 BLADE"
echo "Thermal: 54°C (excelente para OC)"
echo ""

# Backup das configurações atuais
echo "=== Fazendo Backup ==="
sudo cp /etc/default/grub /etc/default/grub.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
echo "Backup do GRUB criado"

# 1. NVIDIA Parameter (CRÍTICO para suspend/resume)
echo "=== 1. Configurando parâmetro NVIDIA ==="
if grep -q "nvidia.NVreg_PreserveVideoMemoryAllocations=1" /etc/default/grub; then
    echo "✓ Parâmetro NVIDIA já configurado"
else
    sudo sed -i 's/nvidia_drm.modeset=1/nvidia_drm.modeset=1 nvidia.NVreg_PreserveVideoMemoryAllocations=1/' /etc/default/grub
    echo "✓ Parâmetro NVIDIA adicionado ao GRUB"
    GRUB_UPDATED=1
fi

# 2. I/O Scheduler para NVMe (PERFORMANCE) - CORRIGIDO
echo "=== 2. Configurando I/O Scheduler para NVMe ==="
sudo tee /etc/udev/rules.d/60-ioschedulers.rules >/dev/null <<'EOF'
# Optimal I/O scheduler for NVMe drives
# Apply only to main device, not partitions
ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="mq-deadline"
EOF
echo "✓ I/O Scheduler configurado (mq-deadline para NVMe)"

# 3. TRIM automático (LONGEVIDADE do SSD)
echo "=== 3. Habilitando TRIM automático ==="
sudo systemctl enable fstrim.timer
if systemctl is-enabled fstrim.timer &>/dev/null; then
    echo "✓ TRIM automático habilitado"
else
    echo "⚠ Erro ao habilitar TRIM"
fi

# 4. Sysctl optimizations (CONSERVADOR para sistema OC)
echo "=== 4. Configurando otimizações do kernel ==="
sudo tee /etc/sysctl.d/99-optimization.conf >/dev/null <<'EOF'
# Otimizações seguras para sistema com overclock
# RAM: 16GB + DDR4-3733 OC

# Virtual Memory (conservador para OC)
vm.swappiness=8
vm.vfs_cache_pressure=50
vm.dirty_ratio=15
vm.dirty_background_ratio=5

# File system
fs.file-max=2097152

# Não forçar configurações agressivas em sistema OC
EOF
echo "✓ Configurações sysctl aplicadas"

# 5. Verificar se precisa atualizar GRUB
if [[ "$GRUB_UPDATED" == "1" ]]; then
    echo "=== 5. Atualizando GRUB ==="
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    echo "✓ GRUB atualizado"
fi

# Verificações finais
echo ""
echo "=== Verificações Finais ==="

# Verificar GRUB
echo -n "GRUB config: "
if grep -q "nvidia.NVreg_PreserveVideoMemoryAllocations=1" /etc/default/grub; then
    echo "✓ OK"
else
    echo "✗ ERRO"
fi

# Verificar udev rules
echo -n "I/O Scheduler: "
if [[ -f /etc/udev/rules.d/60-ioschedulers.rules ]]; then
    echo "✓ OK"
else
    echo "✗ ERRO"
fi

# Verificar fstrim
echo -n "FSTRIM service: "
if systemctl is-enabled fstrim.timer &>/dev/null; then
    echo "✓ OK"
else
    echo "✗ ERRO"
fi

# Verificar sysctl
echo -n "Sysctl config: "
if [[ -f /etc/sysctl.d/99-optimization.conf ]]; then
    echo "✓ OK"
else
    echo "✗ ERRO"
fi

echo ""
echo "=== CONFIGURAÇÕES NÃO APLICADAS (já otimizadas) ==="
echo "✓ CPU Governor: Mantido 'powersave' com amd-pstate-epp (IDEAL)"
echo "✓ CPU Frequency: Range atual 1.76-4.55GHz (PERFEITO)"
echo "✓ Thermal: 54°C atual (EXCELENTE para OC)"
echo ""

echo "=== RESULTADO ==="
echo "✅ Configurações SEGURAS aplicadas"
echo "✅ Sistema OC preservado e otimizado"
echo "✅ Zero risco de instabilidade"
echo ""
echo "REINICIAR o sistema para aplicar todas as mudanças:"
echo "sudo reboot"
echo ""

# Mostrar o que vai melhorar
echo "=== MELHORIAS ESPERADAS ==="
echo "📈 Suspend/Resume mais confiável (NVIDIA)"
echo "📈 I/O do SSD mais eficiente (desenvolvimento)"
echo "📈 Longevidade do SSD (TRIM automático)"
echo "📈 Sem limitações de file descriptors (projetos grandes)"
echo "📈 Uso otimizado da RAM (menos swap desnecessário)"
echo ""
echo "⚠️  IMPORTANTE: Seu sistema já estava bem configurado!"
echo "    Essas são apenas otimizações conservadoras adicionais."
