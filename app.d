import core.sys.windows.windows;
import std.stdio;
import std.array;
import std.conv;

extern (Windows) {
    DWORD GetLogicalDriveStringsA(DWORD nBufferLength, LPSTR lpBuffer);
}

void main() {
    char[260] buffer; // El tamaño máximo para GetLogicalDriveStrings es 260
    DWORD drives = GetLogicalDriveStringsA(cast(DWORD) buffer.length, buffer.ptr);

    if (drives == 0) {
        writeln("Error al obtener las letras de unidad.");
        return;
    }

    writeln("Letras de unidad disponibles:");

    auto visibleDrives = split(buffer[0 .. cast(ulong)drives], '\0'); // Dividir la cadena en partes

    foreach (drive; visibleDrives) {
        writeln(to!string(drive)); // Convertir cada parte a una cadena y escribir
    }

    // Buscar la unidad oculta
    writeln("\nLetra de unidad oculta:");

    foreach (char letra; "ABCDEFGHIJKLMNOPQRSTUVWXYZ") {
        string unidad = to!string(letra) ~ ":\\"; // Construir la ruta de unidad
        bool encontrada = false;
        foreach (drive; visibleDrives) {
            if (to!string(drive) == unidad) {
                encontrada = true;
                break;
            }
        }
        if (!encontrada) {
            writeln(unidad);
            break;
        }
    }
}
